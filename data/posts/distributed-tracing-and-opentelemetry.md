{---
title = "Monitoring Go Apps with Distributed Tracing and OpenTelemetry";
tags = [ "code" "go" "tracing" "telemetry" "uptrace" ];
date = "2022-04-28";
path = "/posts/distributed-tracing-and-opentelemetry";
author = {
  name = "Vladimir Mihailenco";
  url = https://github.com/vmihailenco;
};
---}

{{ templates.partials.taxonomyTermsList "tags" meta.tags }}

*The following is a guest article written by [Vladimir Mihailenco](https://github.com/vmihailenco) from [Uptrace](https://uptrace.dev).*

# Monitoring Go Apps with Distributed Tracing and OpenTelemetry

## What is tracing?

[Distributed tracing](https://opentelemetry.uptrace.dev/guide/distributed-tracing.html) allows to
precisely pinpoint the problem in complex systems, especially those built using a microservices
architecture.

Tracing allow to follow requests as they travel through distributed systems. You get a full context
of what is different, what is broken, and which logs & errors are relevant.

![Distributed Tracing]({{ meta.path }}/tracing-graph.png)

Using tracing, you can break down requests into
[spans](https://opentelemetry.uptrace.dev/guide/distributed-tracing.html#spans). A **span** is an
operation (unit of work) your app performs handling a request, for example, a database query or a
network call.

A **trace** is a tree of spans that shows the path that a request makes through an app.
The root span is the first span in a trace.

![Trace]({{ meta.path }}/trace-graph.png)

To learn more about tracing, see
[Distributed tracing using OpenTelemetry](https://opentelemetry.uptrace.dev/guide/distributed-tracing.html).

## What is OpenTelemetry?

[OpenTelemetry](https://opentelemetry.uptrace.dev/) is an open-source observability framework for
[distributed tracing](https://opentelemetry.uptrace.dev/guide/distributed-tracing.html) (including
logs and errors) and [metrics](https://opentelemetry.uptrace.dev/guide/metrics.html).

Otel allows developers to collect and export telemetry data in a vendor agnostic way. With
OpenTelemetry, you can [instrument](https://opentelemetry.uptrace.dev/instrumentations/) your
application once and then add or change vendors without changing the instrumentation, for example,
here is a list [popular DataDog alternatives](https://get.uptrace.dev/compare/datadog-competitors.html) that support
OpenTelemetry.

## How to use OpenTelemetry?

OpenTelemetry is available for most programming languages and provides interoperability across
different languages and environments.

You can [get started with OpenTelemetry](https://opentelemetry.uptrace.dev/) by following these 5 steps:

- **Step 1**. Install a
  [distributed tracing tool](https://get.uptrace.dev/compare/distributed-tracing-tools.html).

- **Step 2**. Browse
  [OpenTelemetry instrumentations](https://opentelemetry.uptrace.dev/instrumentations/) to find
  examples for your framework and libraries.

- **Step 3**. [Configure](https://docs.uptrace.dev/#getting-started) the OpenTelemetry SDK to export
  telemetry data to the tracing tool.

- **Step 4**. Learn about
  [OpenTelemetry Tracing API](https://opentelemetry.uptrace.dev/guide/distributed-tracing.html#what-s-next)
  for your programming language to create custom instrumentations.

- **Step 5**. Install
  [OpenTelemetry Collector](https://opentelemetry.uptrace.dev/guide/collector.html) to gather
  [infrastructure metrics](https://opentelemetry.uptrace.dev/guide/collector.html#host-metrics).

## OpenTelemetry Go API

You can create spans using
[OpenTelemetry Go API](https://opentelemetry.uptrace.dev/guide/go-tracing.html) like this:

```go
import "go.opentelemetry.io/otel"

var tracer = otel.Tracer("app_or_package_name")

func someFunc(ctx context.Context) error {
	ctx, span := tracer.Start(ctx, "some-func")
	defer span.End()

	// the code you are measuring

	return nil
}
```

You can also record
[attributes](https://opentelemetry.uptrace.dev/guide/distributed-tracing.html#attributes) and
errors:

```go
func someFunc(ctx context.Context) error {
	ctx, span := tracer.Start(ctx, "some-func")
	defer span.End()

	if span.IsRecording() {
		span.SetAttributes(
			attribute.Int64("enduser.id", userID),
			attribute.String("enduser.email", userEmail),
		)
	}

	if err := someOtherFunc(ctx); err != nil {
		span.RecordError(err)
		span.SetStatus(codes.Error, err.Error())
	}

	return nil
}
```

## What is Uptrace?

[Uptrace](https://uptrace.dev/) is an open source
[DataDog alternative](https://get.uptrace.dev/compare/datadog-competitors.html) that helps developers pinpoint failures and
find performance bottlenecks. Uptrace can process billions of spans on a single server and allows to
monitor your software at 10x lower cost.

Uptrace accepts data from OpenTelemetry and stores it in a ClickHouse database. ClickHouse is a
columnar database that is much more efficient for traces and logs than, for example, Elastic Search.
On the same hardware, ClickHouse can store 10x more traces and, at the same time, provide much
better performance.

You can [install Uptrace](https://get.uptrace.dev/guide/opentelemetry-tracing-tool.html) by downloading a DEB/RPM package
or a pre-compiled binary.

![Uptrace tracing tool]({{ meta.path }}/uptrace.png)

## What's next?

Next, you can continue exploring [OpenTelemetry](https://opentelemetry.uptrace.dev) or start
instrumenting your app using popular instrumentations:

- [OpenTelemetry guide for Gin and GORM](https://get.uptrace.dev/opentelemetry/gin-gorm.html)
- [gRPC OpenTelemetry](https://opentelemetry.uptrace.dev/instrumentations/go-grpc.html)
- [Golang ORM OpenTelemetry](https://bun.uptrace.dev/guide/performance-monitoring.html)
- [Go Redis OpenTelemetry](https://redis.uptrace.dev/guide/go-redis-monitoring.html)
- [Zap OpenTelemetry](https://opentelemetry.uptrace.dev/instrumentations/go-zap.html)

{{ lib.strings.replaceStrings [ "\n\n" ] [ "\n" ] (templates.services.disqus { inherit (meta) path; }) }}

pub usingnamespace @cImport({
    @cDefine("H2O_USE_LIBUV", "0");
    @cInclude("h2o.h");
});

pub const h2o = struct {
    // TODO check if we can make these comptime by not using h2o_lookup_token and building the struct directly
    pub var TOKEN_AUTHORITY: *const h2o_token_t;
    pub var TOKEN_METHOD: *const h2o_token_t;
    pub var TOKEN_PATH: *const h2o_token_t;
    pub var TOKEN_SCHEME: *const h2o_token_t;
    pub var TOKEN_ACCEPT: *const h2o_token_t;
    pub var TOKEN_ACCEPT_CHARSET: *const h2o_token_t;
    pub var TOKEN_ACCEPT_ENCODING: *const h2o_token_t;
    pub var TOKEN_ACCEPT_LANGUAGE: *const h2o_token_t;
    pub var TOKEN_ACCEPT_RANGES: *const h2o_token_t;
    pub var TOKEN_ACCESS_CONTROL_ALLOW_ORIGIN: *const h2o_token_t;
    pub var TOKEN_AGE: *const h2o_token_t;
    pub var TOKEN_ALLOW: *const h2o_token_t;
    pub var TOKEN_AUTHORIZATION: *const h2o_token_t;
    pub var TOKEN_CACHE_CONTROL: *const h2o_token_t;
    pub var TOKEN_CACHE_DIGEST: *const h2o_token_t;
    pub var TOKEN_CONNECTION: *const h2o_token_t;
    pub var TOKEN_CONTENT_DISPOSITION: *const h2o_token_t;
    pub var TOKEN_CONTENT_ENCODING: *const h2o_token_t;
    pub var TOKEN_CONTENT_LANGUAGE: *const h2o_token_t;
    pub var TOKEN_CONTENT_LENGTH: *const h2o_token_t;
    pub var TOKEN_CONTENT_LOCATION: *const h2o_token_t;
    pub var TOKEN_CONTENT_RANGE: *const h2o_token_t;
    pub var TOKEN_CONTENT_TYPE: *const h2o_token_t;
    pub var TOKEN_COOKIE: *const h2o_token_t;
    pub var TOKEN_DATE: *const h2o_token_t;
    pub var TOKEN_EARLY_DATA: *const h2o_token_t;
    pub var TOKEN_ETAG: *const h2o_token_t;
    pub var TOKEN_EXPECT: *const h2o_token_t;
    pub var TOKEN_EXPIRES: *const h2o_token_t;
    pub var TOKEN_FROM: *const h2o_token_t;
    pub var TOKEN_HOST: *const h2o_token_t;
    pub var TOKEN_HTTP2_SETTINGS: *const h2o_token_t;
    pub var TOKEN_IF_MATCH: *const h2o_token_t;
    pub var TOKEN_IF_MODIFIED_SINCE: *const h2o_token_t;
    pub var TOKEN_IF_NONE_MATCH: *const h2o_token_t;
    pub var TOKEN_IF_RANGE: *const h2o_token_t;
    pub var TOKEN_IF_UNMODIFIED_SINCE: *const h2o_token_t;
    pub var TOKEN_KEEP_ALIVE: *const h2o_token_t;
    pub var TOKEN_LAST_MODIFIED: *const h2o_token_t;
    pub var TOKEN_LINK: *const h2o_token_t;
    pub var TOKEN_LOCATION: *const h2o_token_t;
    pub var TOKEN_MAX_FORWARDS: *const h2o_token_t;
    pub var TOKEN_PROXY_AUTHENTICATE: *const h2o_token_t;
    pub var TOKEN_PROXY_AUTHORIZATION: *const h2o_token_t;
    pub var TOKEN_RANGE: *const h2o_token_t;
    pub var TOKEN_REFERER: *const h2o_token_t;
    pub var TOKEN_REFRESH: *const h2o_token_t;
    pub var TOKEN_RETRY_AFTER: *const h2o_token_t;
    pub var TOKEN_SERVER: *const h2o_token_t;
    pub var TOKEN_SET_COOKIE: *const h2o_token_t;
    pub var TOKEN_STRICT_TRANSPORT_SECURITY: *const h2o_token_t;
    pub var TOKEN_TE: *const h2o_token_t;
    pub var TOKEN_TRANSFER_ENCODING: *const h2o_token_t;
    pub var TOKEN_UPGRADE: *const h2o_token_t;
    pub var TOKEN_USER_AGENT: *const h2o_token_t;
    pub var TOKEN_VARY: *const h2o_token_t;
    pub var TOKEN_VIA: *const h2o_token_t;
    pub var TOKEN_WWW_AUTHENTICATE: *const h2o_token_t;
    pub var TOKEN_X_COMPRESS_HINT: *const h2o_token_t;
    pub var TOKEN_X_FORWARDED_FOR: *const h2o_token_t;
    pub var TOKEN_X_REPROXY_URL: *const h2o_token_t;
    pub var TOKEN_X_TRAFFIC: *const h2o_token_t;

    pub const METHOD_GET = "GET";
    pub const METHOD_POST = "POST";
    pub const METHOD_PUT = "PUT";
    pub const METHOD_PATCH = "PATCH";
    pub const METHOD_OPTIONS = "OPTIONS";
    pub const METHOD_HEAD = "HEAD";
    pub const METHOD_DELETE = "DELETE";
    pub const METHOD_TRACE = "TRACE";
    pub const METHOD_CONNECT = "CONNECT";

    pub const CONTENT_TYPE_TEXT_PLAIN = "text/plain";

    pub fn _init() void {
        // TODO missing tokens
        // TOKEN_AUTHORITY = lookup_token("");
        // TOKEN_METHOD = lookup_token("");
        // TOKEN_PATH = lookup_token("");
        // TOKEN_SCHEME = lookup_token("");
        TOKEN_ACCEPT = lookup_token("accept");
        TOKEN_ACCEPT_CHARSET = lookup_token("accept-charset");
        TOKEN_ACCEPT_ENCODING = lookup_token("accept-encoding");
        TOKEN_ACCEPT_LANGUAGE = lookup_token("accept-language");
        TOKEN_ACCEPT_RANGES = lookup_token("accept-ranges");
        TOKEN_ACCESS_CONTROL_ALLOW_ORIGIN = lookup_token("access-control-allow-origin");
        TOKEN_AGE = lookup_token("age");
        TOKEN_ALLOW = lookup_token("allow");
        TOKEN_AUTHORIZATION = lookup_token("authorization");
        TOKEN_CACHE_CONTROL = lookup_token("cache-control");
        TOKEN_CACHE_DIGEST = lookup_token("cache-digest");
        TOKEN_CONNECTION = lookup_token("connection");
        TOKEN_CONTENT_DISPOSITION = lookup_token("content-disposition");
        TOKEN_CONTENT_ENCODING = lookup_token("content-encoding");
        TOKEN_CONTENT_LANGUAGE = lookup_token("content-language");
        TOKEN_CONTENT_LENGTH = lookup_token("content-length");
        TOKEN_CONTENT_LOCATION = lookup_token("content-location");
        TOKEN_CONTENT_RANGE = lookup_token("content-range");
        TOKEN_CONTENT_TYPE = lookup_token("content-type");
        TOKEN_COOKIE = lookup_token("cookie");
        TOKEN_DATE = lookup_token("date");
        TOKEN_EARLY_DATA = lookup_token("early-data");
        TOKEN_ETAG = lookup_token("etag");
        TOKEN_EXPECT = lookup_token("expect");
        TOKEN_EXPIRES = lookup_token("expires");
        TOKEN_FROM = lookup_token("from");
        TOKEN_HOST = lookup_token("host");
        TOKEN_HTTP2_SETTINGS = lookup_token("http2-settings");
        TOKEN_IF_MATCH = lookup_token("if-match");
        TOKEN_IF_MODIFIED_SINCE = lookup_token("if-modified-since");
        TOKEN_IF_NONE_MATCH = lookup_token("if-none-match");
        TOKEN_IF_RANGE = lookup_token("if-range");
        TOKEN_IF_UNMODIFIED_SINCE = lookup_token("if-unmodified-since");
        TOKEN_KEEP_ALIVE = lookup_token("keep-alive");
        TOKEN_LAST_MODIFIED = lookup_token("last-modified");
        TOKEN_LINK = lookup_token("link");
        TOKEN_LOCATION = lookup_token("location");
        TOKEN_MAX_FORWARDS = lookup_token("max-forwards");
        TOKEN_PROXY_AUTHENTICATE = lookup_token("proxy-authenticate");
        TOKEN_PROXY_AUTHORIZATION = lookup_token("proxy-authorization");
        TOKEN_RANGE = lookup_token("range");
        TOKEN_REFERER = lookup_token("referer");
        TOKEN_REFRESH = lookup_token("refresh");
        TOKEN_RETRY_AFTER = lookup_token("retry-after");
        TOKEN_SERVER = lookup_token("server");
        TOKEN_SET_COOKIE = lookup_token("set-cookie");
        TOKEN_STRICT_TRANSPORT_SECURITY = lookup_token("strict-transport-security");
        TOKEN_TE = lookup_token("te");
        TOKEN_TRANSFER_ENCODING = lookup_token("transfer-encoding");
        TOKEN_UPGRADE = lookup_token("upgrade");
        TOKEN_USER_AGENT = lookup_token("user-agent");
        TOKEN_VARY = lookup_token("vary");
        TOKEN_VIA = lookup_token("via");
        TOKEN_WWW_AUTHENTICATE = lookup_token("www-authenticate");
        TOKEN_X_COMPRESS_HINT = lookup_token("x-compress-hint");
        TOKEN_X_FORWARDED_FOR = lookup_token("x-forwarded-for");
        TOKEN_X_REPROXY_URL = lookup_token("x-reproxy-url");
        TOKEN_X_TRAFFIC = lookup_token("x-traffic");
    }

    pub fn lookup_token(name: []const u8) *const h2o_token_t {
        return h2o_lookup_token(&name[0], name.len);
    }

    pub fn iovec_init(data: var) h2o_iovec_t {
        return h2o_iovec_init(data, data.len);
    }

    pub fn _from_iovec(data: h2o_iovec_t) []u8 {
        return data.base[0..data.len];
    }
};

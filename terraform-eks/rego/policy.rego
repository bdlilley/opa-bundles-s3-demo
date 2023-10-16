package httpbin
   
import input.http_request
   
# deny requests by default
default allowed = false
   
# set allowed to true if no error message
allowed {
    not body
}
   
# return result and error message
allow["allowed"] = allowed
allow["body"] = body

# main policy logic, with error message per rule
body = "HTTP verb is not allowed" { not http_verb_allowed }
else = "Path is not allowed" { not path_allowed }

# allow only GET and POST requests
http_verb_allowed {
   {"GET", "POST"}[_] == http_request.method
}

# deny requests to /status endpoint
path_allowed {
   not startswith(http_request.path, "/status")
}

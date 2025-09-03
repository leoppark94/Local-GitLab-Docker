statedb = "./db/lorries.sqlite"
working-area = "./workd"
maximum-redirects = 1
namespace_depth = 4
port = 3000

[logging]
level = "INFO"

[[config-source]]
kind = "local"
path = "./config_source"

[[config-source]]
kind = "local"
path = "./config_source_2"

[downstream]
kind = "gitlab"
username = "oauth2"
hostname = "${hostname}"
insecure-http = true
private-token-file = "./lorry_auth/lorry.token"

[clone]
engine = "GitBinary"
n-threads = 1

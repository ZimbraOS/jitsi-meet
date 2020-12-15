# zm-jitsi

# Server Setup
https://jitsi.github.io/handbook/docs/devops-guide/devops-guide-quickstart

## Secure Domain Config
### Deploy LDAP Prosody Configuration
Add ldap.cfg.lua to `/etc/prosody/conf.available` then create symlink to activate it.
```
ln -sf /etc/prosody/conf.avail/ldap.cfg.lua /etc/prosody/conf.d/
```
#### Patch to allow for authentication from multiple domains
* Update the function `provider.test_password` in `/usr/lib/prosody/modules/mod_auth_ldap2/mod_auth_ldap2.lua`. Note '.at.' can be any value, but must match the value we substitute the '@' with in the email address. This is a workaround to enable authentication from multiple domains in the same instance. See this jitsi bug report for more information: https://github.com/jitsi/docker-jitsi-meet/issues/173
```
function provider.test_password(username, password)
    local username = string.gsub(username, '.at.', '@');
    return ldap.bind(username, password);
end
```
* Update the function in the jitsi-web codebase at `react/features/base/connection/functions.js`
```
export function toJid(id: string, { authdomain, domain }: Object): string {
    return `${id.split('@').join('.at.')}@${authdomain || domain}`;
}
```

### Setup authentication
```
VirtualHost "[your-hostname]"
    authentication = "ldap2"
```

`/etc/prosody/conf.avail/[your-hostname].cfg.lua`
```
VirtualHost "guest.jitsi-meet.example.com"
    authentication = "anonymous"
    c2s_require_encryption = false
```

# UI Customizations
* Ensure you have a recent version of node installed
```
nvm install --lts
nvm use --lts
npm install
```

* Edit the customized version of jitsi-meet and run `make`

-- https://modules.prosody.im/mod_lib_ldap.html
-- https://modules.prosody.im/mod_auth_ldap2.html
-- /etc/prosody/conf.avail/ldap.cfg.lua
-- to enable: 
authentication = 'ldap2'

ldap = {
    hostname = '<<SET-THIS>>',
    bind_dn = 'uid=zmpostfix,cn=appaccts,cn=zimbra',
    bind_password = '<<GET FROM: zmc-secrets ldap.postfix_password>>',
    use_tls = false,
    user = {
        usernamefield = mail,
        namefield='cn',
        basedn = '',
        filter = '(objectClass=zimbraAccount)'
    },
}

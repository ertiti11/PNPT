## Connect

### LDAP Search

You can connect to an LDAP server and perform a search using the ldapsearch command. Example usage:

```bash
ldapsearch -x -h <ldap-server> -b <base-dn> -D <bind-dn> -w <password> -s <search-scope> <filter>
```

### LDAP Auth

```bash
ldapwhoami -x -h <ldap-server> -D <bind-dn> -w <password>
```

## Recon

### LDAP Server Information

To gather information from an LDAP server, you can use the ldapsearch command. For example, to list all objects:

```bash
ldapsearch -x -h <ldap-server> -b "" -s base "(objectclass=*)"
```

## Enumeration

### Enumerate Users

LDAP queries can be used to enumerate users. For example, to list all users:

```bash
ldapsearch -x -h <ldap-server> -b "ou=users,dc=example,dc=com" "(objectclass=inetOrgPerson)"
```
### Dumping Directory Information

Extracting sensitive information such as user credentials, group memberships, and organizational units from the LDAP server.

```bash
ldapsearch -h <LDAP-server> -p <port> -x -b "<base-DN>" "(objectclass=*)"
```


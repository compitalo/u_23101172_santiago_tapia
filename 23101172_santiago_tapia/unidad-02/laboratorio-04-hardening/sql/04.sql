SHOW listen_addresses;

SHOW ssl;

SELECT
    pid,
    usename,
    client_addr,
    ssl,
    version,
    cipher
FROM pg_stat_ssl
WHERE pid = pg_backend_pid();

SELECT
    rolname,
    rolsuper
FROM pg_roles
ORDER BY rolname;
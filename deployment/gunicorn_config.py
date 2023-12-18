# Gunicorn configuration file
# https://docs.gunicorn.org/en/stable/configure.html#configuration-file
# https://docs.gunicorn.org/en/stable/settings.html


workers = 3
max_requests = 1000
max_requests_jitter = 50

log_file = "-"
accesslog = "-"
access_log_format = '[gunicorn-access-log] "%(r)s" %(s)s %(b)s'

# Iodine setup - use conditional setup to allow command-line arguments to override these:
# puts("------------------------------\n\n       STARTING IODINE\n        at port: 3000\n\n------------------------------")
# if(defined?(Iodine))
#   RAILS_MAX_THREADS = 5
#   WEB_CONCURRENCY = 2
#   PORT = 3000

#   Iodine.threads = ENV.fetch("RAILS_MAX_THREADS", RAILS_MAX_THREADS).to_i if Iodine.threads.zero?
#   Iodine.workers = ENV.fetch("WEB_CONCURRENCY", WEB_CONCURRENCY).to_i if Iodine.workers.zero?
#   Iodine::DEFAULT_SETTINGS[:port] = PORT
# end
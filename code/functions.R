# functions.R
# Helper functions used across scripts. Loaded by 00_setup.R.

# Record one API request in data/retrieval_log.csv.
# The log is tracked by Git; the raw files it describes are not.
log_retrieval <- function(source, request, file, rows, package) {
  entry <- data.frame(
    retrieved = format(Sys.time(), "%Y-%m-%d %H:%M %Z"),
    source    = source,
    request   = request,
    file      = file,
    rows      = rows,
    package   = paste(package, packageVersion(package)),
    r_version = paste(R.version$major, R.version$minor, sep = ".")
  )
  log_file <- "data/retrieval_log.csv"
  write_csv(entry, log_file, append = file.exists(log_file))
}

# Stop unless `key` columns identify each row of `data` exactly once.
# Call before every join: a duplicated key silently multiplies rows.
check_key <- function(data, key) {
  label <- deparse(substitute(data))
  if (anyNA(data[key])) {
    stop(sprintf("%s: missing values in key (%s)", label, paste(key, collapse = ", ")))
  }
  n_dup <- sum(duplicated(data[key]))
  if (n_dup > 0) {
    stop(sprintf("%s: %d duplicated rows for key (%s)", label, n_dup, paste(key, collapse = ", ")))
  }
  invisible(data)
}

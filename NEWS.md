# conbenchcoms 0.0.7
* Remove `sha`, `simplifyVector`, and `flatten` arguments from `runs`
* Add `commit_hashes` argument to `runs`
* `runs` now always returns a `tibble`
* `runs` now paginates until all matching data is returned, which works only with Conbench servers of at least version [7e4d9d0](https://github.com/conbench/conbench/commit/7e4d9d0)
* Make `benchmarks` defunct

# conbenchcoms 0.0.6
* Remove `batch_id`, `limit`, `days`, `simplifyVector`, and `flatten` arguments from `benchmark_results`
* Add `earliest_timestamp` and `latest_timestamp` arguments to `benchmark_results`
* `benchmark_results` now always returns a `tibble`
* The `run_id` argument of `benchmark_results` can now only take 1 ID
* `benchmark_results` now is able to accept any combination of filters instead of requiring 1 at a time
* `benchmark_results` now paginates until *all* matching data is returned, which works only with Conbench servers of at least version [6c1b93](https://github.com/conbench/conbench/commit/6c1b93)

# conbenchcoms 0.0.5
* display more verbose errors when the Conbench API returns an error

# conbenchcoms 0.0.4
* add threshold endpoints to conbenchcoms

# conbenchcoms 0.0.3
* add limit and days parameters to `benchmark_results`

# conbenchcoms 0.0.2

* Add run_reason argument to `benchmark_results`
* deprecated `benchmark` in favour of `benchmark_results`
* Hard dependency on httr 0.2.2 for escaping capabilities
* Enforce only 5 run_ids for `benchmark_results`
* Assert that `benchmark_results` can only use one of run_id, batch_id or run_reason

# conbenchcoms 0.0.1

* Initial version of conbenchcoms

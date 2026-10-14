# Lab diary

Dated notes on what was tried, what worked, and what to do next. Commit
messages record *what* changed; the diary records the thinking around it,
including things that did not make it into the code.

## 2026-10-14

- Split the single Lecture 5.2 script into numbered scripts with `run_all.R`.
- Raw files stay on disk and out of Git. The CDL raster for one county is about
  10 MB; a multi-state panel would be gigabytes.
- USGS returns daily *mean* discharge (statistic 00003) with an approval status
  and qualifier per day. All 183 days are Approved, but 72 carry the qualifier
  REVISED: USGS changed those values after first publishing them. A download
  from mid-2024 would differ from ours.
- NASA POWER describes a grid cell of roughly 0.5° x 0.625°, not Fort Collins
  itself. The same weather values apply to every location in the cell.
- Next: combine flow and weather by date and check the key (Lecture 5.4).

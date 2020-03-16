# Get required file names in directory
# 2020-01-21 T14:30 RT

# Set my directory
my_dir <- scan(file = "dir.txt", what = "character")

# Get all file names
file_names <- list.files(
  path = my_dir
  , pattern = '_R([0-9]+).H5' # review -> take only _R12345
  , recursive = F
)[1:N]

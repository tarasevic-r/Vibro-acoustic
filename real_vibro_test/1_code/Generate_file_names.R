# Generate file names

# set files directory
my_dir <- "/home/robert/git/Vibro-acoustic/2nd_test/"
# Get all file names
file_names <- list.files(
  path = my_dir
  , pattern = '2004.02.([0-9]+)' 
  , recursive = F
)#[1:N]

# Obtained maps from http://www.naturalearthdata.com/downloads/50m-cultural-vectors/
download.file(url = "http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
              destfile = "data/world-shape-files.zip")
unzip("data/world-shape-files.zip", exdir = "data/world-shape-files")
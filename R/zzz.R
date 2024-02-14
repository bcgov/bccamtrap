# Define classes as a subclass of sf so that it works
# with S4 methods for sf (eg mapview)
methods::setOldClass(c("sample_sessions", "sf"))
methods::setOldClass(c("sample_station_info", "sf"))

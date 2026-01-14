#include "csv_filler.h"
#include <cstring>

CsvFiller::CsvFiller() : _filename("filename.csv") {}
CsvFiller::CsvFiller(char filename[32]) { strcpy(_filename, filename); }

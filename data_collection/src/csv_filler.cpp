#include "csv_filler.h"

#include <cstring>

CsvFiller::CsvFiller() : _filename("filename.csv") {}
CsvFiller::CsvFiller(char filename[32]) { strcpy(_filename, filename); }
CsvFiller::~CsvFiller() { closeFile(); }

void CsvFiller::openFile() { _fd.open(_filename); }
void CsvFiller::closeFile() { _fd.close(); }
void CsvFiller::writeString(char *str) { _fd << str; }
void CsvFiller::writeData(double time, double err) {
  _fd << time << "," << err << "\n";
}

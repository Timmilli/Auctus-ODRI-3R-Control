#pragma once

#include <fstream>

class CsvFiller {
private:
  char _filename[32];
  std::ofstream _fd;

public:
  CsvFiller();
  CsvFiller(char filename[32]);
  ~CsvFiller();
  /* TODO switch to a dynamic filename
   * CsvFiller();
   * CsvFiller(char *filename);
   */

  void openFile();
  void closeFile();
  void writeString(char *str);
  void writeData(double time, double err);
};

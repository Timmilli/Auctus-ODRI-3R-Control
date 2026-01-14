class CsvFiller {
private:
  char _filename[32];

public:
  CsvFiller();
  CsvFiller(char filename[32]);
  CsvFiller(char filename[32], char *header);
  ~CsvFiller();

  void Write(char *data);
};

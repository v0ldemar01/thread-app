import { IExtractorDto } from '../dto/extractor.dto';

export const extractResource = <T, K extends T>(
  data: IExtractorDto<T>,
  keyWord: string,
): K[] => {
  const finalObjectDto = data.entities as K[];
  data.raw.forEach((rowElement, index) => {
    Object.entries(rowElement).forEach(([key, value]) => {
      if (key.toLowerCase().includes(keyWord)) {
        const currentEntity = finalObjectDto[index];
        currentEntity[key] = value ? parseInt(value as string) : 0;
      }
    });
  });

  return finalObjectDto;
};

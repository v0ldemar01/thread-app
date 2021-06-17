export interface IObject {
  [key: string]: string | Date | boolean | number | null;
}

export type ITObject<T> = IObject & T;

export interface IExtractorDto<T> {
  raw: IObject[];
  entities: T[];
}

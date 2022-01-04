export class PersistenceErrorException extends Error {
  constructor(entityTypeName: string, error: string, operationName: string, operationData: string) {
    super(`${entityTypeName} persistence operation threw error(${error})${'. ' + operationName + '(' + operationData + ') failed.'}`);
  }
}

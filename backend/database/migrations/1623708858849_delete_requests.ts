import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class DeleteRequests extends BaseSchema {
  protected tableName = 'delete_requests'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id')
      table.integer("user_id").unsigned().notNullable().references("id").inTable("users")
      table.integer("project_id").unsigned().notNullable().references("id").inTable("projects")
      
      /**
       * Uses timestampz for PostgreSQL and DATETIME2 for MSSQL
       */
      table.timestamp('created_at', { useTz: true })
      table.timestamp('updated_at', { useTz: true })
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}

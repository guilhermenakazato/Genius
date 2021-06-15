import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class UsersTags extends BaseSchema {
  protected tableName = 'users_tags'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id')
      table.integer("tag_id").unsigned().notNullable().references("id").inTable("tags")
      table.integer("user_id").unsigned().notNullable().references("id").inTable("users")

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

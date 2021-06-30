import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class Followers extends BaseSchema {
  protected tableName = 'followers'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id')
      table.integer("user_id").unsigned().notNullable().references("id").inTable("users")
      table.integer("follower_id").unsigned().notNullable().references("id").inTable("users")

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

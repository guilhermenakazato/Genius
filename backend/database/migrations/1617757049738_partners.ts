import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class Partners extends BaseSchema {
  protected tableName = 'partners'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id')
      table.integer("follower").references("id").inTable("users")
      table.integer("following").references("id").inTable("users")
      table.unique(["follower", "following"])
      table.timestamps(true)
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}

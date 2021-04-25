import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class ProjectsTags extends BaseSchema {
  protected tableName = 'projects_tags'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id')
      table.integer("tag_id").unsigned().notNullable().references("id").inTable("tags")
      table.integer("project_id").unsigned().notNullable().references("id").inTable("projects")
      table.timestamps(true)
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}

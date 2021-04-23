import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class ProjectsParticipants extends BaseSchema {
  protected tableName = 'projects_participants'

  public async up () {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()
      table.integer("participant_id").notNullable().references("id").inTable("users")
      table.integer("project_id").notNullable().references("id").inTable("projects")
      table.unique(["participant_id", "project_id"])
      table.timestamps(true)
    })
  }

  public async down () {
    this.schema.dropTable(this.tableName)
  }
}

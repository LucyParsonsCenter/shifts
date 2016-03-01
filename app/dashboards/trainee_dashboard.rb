require "administrate/base_dashboard"

class TraineeDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    events: Field::HasMany,
    id: Field::Number,
    first_name: Field::Text,
    email_address: Field::Text,
    phone_number: Field::Text,
    notes: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    last_name: Field::Text,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :events,
    :id,
    :first_name,
    :email_address,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :events,
    :id,
    :first_name,
    :email_address,
    :phone_number,
    :notes,
    :created_at,
    :updated_at,
    :last_name,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :events,
    :first_name,
    :email_address,
    :phone_number,
    :notes,
    :last_name,
  ]

  # Overwrite this method to customize how trainees are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(trainee)
  #   "Trainee ##{trainee.id}"
  # end
end

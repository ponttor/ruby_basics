class Translations
  MAIN = {
    errors: {
      invalid_input: "Invalid input, please try again"
    }
  }.freeze

  STATION = {
    create: 'Enter the name of the station:',
    not_found: "Station '%s' is not found.",
    created: "Station '%s' has been created.",
    create_failed: "Failed to create station '%s'.",
    action: "Enter station name for '%s'."
  }.freeze

  TRAIN = {
    number: 'Enter the train number:',
    type: 'Select the type of train: 1 - passenger, 2 - cargo',
    created: "Train №%s has been created.",
    forward: '1. Move the train to the next station',
    back: '2. Move the train to the previous station',
    moved_forward: 'The train has been moved to the next station',
    moved_back: 'The train has been moved to the previous station',
    choose: 'Choose a train:',
    errors: {
      invalid_input: "Invalid input",
      incorrect_type: 'Incorrect train type'
    }
  }.freeze  

  ROUTE = {
    attached: "Route successfully assigned to train %s",
    adding: 'adding',
    removal: 'removal',
    start: 'Enter the start station of the route:',
    end: 'Enter the end station of the route:',
    add: '1. Add a station to the route',
    remove: '2. Remove a station from the route',
    created: "Route from %s to %s has been created",
    select_route: 'Choose a route:',
    errors: {
      invalid_input: 'Invalid input',
      default: 'Something went wrong'
    }
  }.freeze

  MOVE_TRAIN = {
    next_station: '1. Move the train to the next station',
    previous_station: '2. Move the train to the previous station'
  }.freeze

  VAGON = {
    added: "Vagon added to train %s.",
    success: 'The vagon has been attached',
    remove: {
      success: "Vagon detached from train %s.",
      no_vagons: "The train has no vagons."
    },
    errors: {
      incorrect_type: 'Incorrect train type',
      wrong_type: 'Cannot attach this type of vagon to the train'
    }
  }.freeze
end
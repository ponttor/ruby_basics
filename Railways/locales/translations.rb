# frozen_string_literal: true

class Translations
  MAIN = {
    errors: {
      invalid_input: 'Invalid input, please try again'
    }
  }.freeze

  STATION = {
    ask_name: 'Enter the name of the station:',
    created: "Station '%s' has been created",
    errors: {
      create_failed: "Failed to create station '%s', try again",
      not_found: "Station '%s' is not found"
    },
    validation: {
      empty: "Name can't be empty"
    },
    action: "Enter station name for '%s'"
  }.freeze

  TRAIN = {
    number: 'Enter the train number:',
    type: 'Select the type of train: 1 - passenger, 2 - cargo',
    created: 'Train %s has been successfully created.',
    forward: '1. Move the train to the next station',
    back: '2. Move the train to the previous station',
    moved_forward: 'The train has been moved to the next station',
    moved_back: 'The train has been moved to the previous station',
    choose: 'Choose a train:',
    passenger: {
      total_seats: 'Enter total number of seats'
    },
    cargo: {
      total_volume: 'Enter total volume'
    },
    errors: {
      create_failed: 'Failed to create a train, try again',
      wrong_type: 'Wrong type',
      wrong_move: 'The move does not exist'
    },
    validation: {
      empty: "Number can't be empty",
      wrong_format: 'Number has invalid format',
      invalid_train: 'Invalid train'
    }
  }.freeze

  ROUTE = {
    start: 'Enter the start station of the route:',
    end: 'Enter the end station of the route:',
    adding: 'adding',
    removal: 'removal',
    add: '1. Add a station to the route',
    remove: '2. Remove a station from the route',
    select_route: 'Choose a route:',

    attached: 'Route successfully assigned to train %s',
    created: 'Route from %s to %s has been created',
    errors: {
      invalid_input: 'Invalid input',
      default: 'Something went wrong',
      invalid_route: 'Invalid route'
    }
  }.freeze

  MOVE_TRAIN = {
    next_station: '1. Move the train to the next station',
    previous_station: '2. Move the train to the previous station'
  }.freeze

  VAGON = {
    added: 'Vagon added to train %s.',
    success: 'The vagon has been attached',
    capacity: 'Enter the capacity',
    remove: {
      success: 'Vagon detached from train %s.',
      no_vagons: 'The train has no vagons.'
    },
    errors: {
      incorrect_type: 'Incorrect train type',
      wrong_type: 'Cannot attach this type of vagon to the train'
    }
  }.freeze

  HELPER = {
    errors: {
      not_found: 'Not found'
    }
  }.freeze
end

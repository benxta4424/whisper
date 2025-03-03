# config/importmap.rb
pin "application", preload: true
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "@hotwired/turbo-rails", to: "@hotwired--turbo-rails.js" # @8.0.12
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@hotwired/turbo", to: "@hotwired--turbo.js" # @8.0.12
pin "@rails/actioncable/src", to: "@rails--actioncable--src.js" # @7.2.201
pin "stimulus-autocomplete" # @3.1.0

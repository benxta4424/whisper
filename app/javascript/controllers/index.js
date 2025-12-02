// File: app/javascript/controllers/index.js

import { application } from "./application";

// Eager load all Stimulus controllers in the current directory and its subdirectories.
// This uses Webpack's require.context utility instead of the @hotwired/stimulus-loading package.
const controllers = require.context(".", true, /_controller\.js$/);
controllers.keys().forEach(controllers);
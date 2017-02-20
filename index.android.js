import CalendarManager from './CalendarManager';

module.exports = {
  ...CalendarManager,
  // Adding events on Android is done by launching a new activity and we don't
  // expect any permission errors
  addEvent: (event, callback) => {
    CalendarManager.addEvent(event);
  }
};

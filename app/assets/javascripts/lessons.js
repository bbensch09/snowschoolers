var LESSON = {
  onReady: function(){
    // important objects
    LESSON._date = $('#datepicker');
    LESSON._slot = $('#lesson_lesson_time_slot');
    LESSON._duration = $('#lesson_duration');
    LESSON._startTime = $('#timepicker');

    // set datepicker
    LESSON.setDatepicker();

    // set and toggle duration enablement
    LESSON.toggleDuration();
    LESSON._slot.change(LESSON.toggleDuration);

    // set and toggle start_time enablement
    LESSON.toggleStartTime();
    LESSON._duration.change(LESSON.toggleStartTime);

    // configure and update timepicker
    LESSON.setTimepicker();
    LESSON._slot.change(LESSON.updateTimepicker);
    LESSON._duration.change(LESSON.updateTimepicker);
  },

  setDatepicker: function() {
    LESSON._date.datepicker({ minDate: 0, dateFormat: 'yy-mm-dd' });
  },

  toggleDuration: function() {
    if (LESSON.slotValid()) {
      LESSON.enable(LESSON._duration);
    } else {
      LESSON.clearAndDisable(LESSON._duration);
      LESSON.clearAndDisable(LESSON._startTime);
    }
  },

  toggleStartTime: function() {
    if (LESSON.slotValid() && LESSON.durationValid()) {
      LESSON.enable(LESSON._startTime);
    } else {
      LESSON.clearAndDisable(LESSON._startTime);
    }
  },

  setTimepicker: function() {
    LESSON._startTime.timepicker();
    LESSON.configureTimepicker();
  },

  updateTimepicker: function() { LESSON.configureTimepicker(true); },

  // private methods

  slotValid: function() {
    var slot = LESSON._slot.val();
    return (slot === 'Morning' || slot === 'Afternoon');
  },

  durationValid: function() {
    var duration = LESSON._duration.val();
    return (duration === '2' || duration === '3');
  },

  enable: function(object) {
    object.prop('disabled', false);
  },

  clearAndDisable: function(object) {
    LESSON.setValue(object, null);
    LESSON.disable(object);
  },

  setValue: function(object, value) {
    object.val(value);
  },

  disable: function(object) {
    object.prop('disabled', true);
  },

  configureTimepicker: function(u) {
    var updating = typeof u !== 'undefined' ? u : false;

    if (LESSON.slotValid() && LESSON.durationValid()) {
      LESSON.setMinAndMaxTime();
      LESSON.checkStartTime(updating);
      LESSON.updateMinAndMaxTime();
    }
  },

  setMinAndMaxTime: function() {
    var slot = LESSON._slot.val();
    var duration = LESSON._duration.val();
    LESSON.setMinTime(slot);
    LESSON.setMaxTime(slot, duration);
  },

  setMinTime: function(slot) {
    LESSON.minTime = (slot === 'Morning' ? '9:00am' : '1:00pm');
  },

  setMaxTime: function(slot, duration) {
    var cases = {
      "Morning|2": '10:30am',
      "Morning|3": '9:30am',
      "Afternoon|2": '2:00pm',
      "Afternoon|3": '1:00pm'
    };

    LESSON.maxTime = cases[slot + "|" + duration];
  },

  checkStartTime: function(updating) {
    if (LESSON.minTime === LESSON.maxTime) {
      if (updating) { LESSON.setValue(LESSON._startTime, LESSON.minTime); }
      LESSON.maxTime = '1:01pm';
    } else {
      if (updating) { LESSON._startTime.val(null); }
    }
  },

  updateMinAndMaxTime: function() {
    LESSON._startTime.timepicker('option', 'minTime', LESSON.minTime);
    LESSON._startTime.timepicker('option', 'maxTime', LESSON.maxTime);
  }
};

$(function(){
  LESSON.onReady();
});

$(window).bind('page:change', function() {
  LESSON.onReady();
});
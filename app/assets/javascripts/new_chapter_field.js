$(document).ready(function() {
  $('#recipe_new_chapter_field').prop('hidden', true);
  $('#recipe_new_chapter_label').prop('hidden', true);
  $('#recipe_new_chapter_field').prop('disabled', true);

  $('select[id="recipe_chapter"]').change(function() {
    if ($(this).val() === "Add New Chapter") {
      $('#recipe_new_chapter_field').prop('hidden', false);
      $('#recipe_new_chapter_label').prop('hidden', false);
      $('#recipe_new_chapter_field').prop('disabled', false);
    } else {
      $('#recipe_new_chapter_field').prop('hidden', true);
      $('#recipe_new_chapter_label').prop('hidden', true);
      $('#recipe_new_chapter_field').prop('disabled', true);
    }
  });
});
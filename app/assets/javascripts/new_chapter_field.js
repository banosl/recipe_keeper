$(document).ready(function() {
  $('#recipe_new_chapter_field').prop('hidden', true);
  $('#recipe_new_chapter_label').prop('hidden', true);
  $('#recipe_new_chapter_field').prop('disabled', true);

  $('#recipe_chapter_id').change(function() {
    var selectedValue = $(this).val();

    if (selectedValue === "new") {
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
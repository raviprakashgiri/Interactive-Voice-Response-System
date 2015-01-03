/* when document is ready */
  $(function() {
    /* initiate plugin */
    $("div.holder").jPages({
        containerID : "itemContainer",
        perPage : 5
    });
    /* on select change */
    $("select").change(function(){
        /* get new nº of items per page */
      var newPerPage = parseInt( $(this).val() );
      /* destroy jPages and initiate plugin again */
      $("div.holder").jPages("destroy").jPages({
            containerID   : "itemContainer",
            perPage       : newPerPage
        });
    });
});
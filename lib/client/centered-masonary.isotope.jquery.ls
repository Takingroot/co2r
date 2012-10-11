$.Isotope::_getCenteredMasonryColumns = ->
  @width = @element.width!
  parentWidth = @element.parent!width!
  colW        = @options.masonry?columnWidth
               # or use the size of the first item
               or @$filteredAtoms.outerWidth(true)
               # if there's no items, use size of container
               or parentWidth

  cols = Math.floor parentWidth / colW
  cols = Math.max cols, 1

  # i.e. this.masonry.cols = ....
  @masonry.cols = cols
  # i.e. this.masonry.columnWidth = ...
  @masonry.columnWidth = colW



$.Isotope::_masonryReset = ->
  # layout-specific props
  @masonry = {}
  # FIXME shouldn't have to call this again
  @_getCenteredMasonryColumns!
  i = @masonry.cols
  @masonry.colYs = []
  while i--
    @masonry.colYs.push 0



$.Isotope::_masonryResizeChanged = ->
  prevColCount = @masonry.cols
  # get updated colCount
  @_getCenteredMasonryColumns!
  @masonry.cols isnt prevColCount



$.Isotope::_masonryGetContainerSize = ->
  unusedCols = 0
  i          = @masonry.cols

  # count unused columns
  while --i
    break if @masonry.colYs[i] isnt 0
    unusedCols++

  return
    height: Math.max.apply( Math, @masonry.colYs )
    # fit container to columns that have been used
    width: (@masonry.cols - unusedCols) * @masonry.columnWidth

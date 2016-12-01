ready = ->
  $('.fileupload-list .gal-item, .folders-list .folder-item').drag('start', (ev, dd) ->
    dd.proxy = $(this).clone()
                      .css('opacity', .75)
                      .css('position', 'absolute')
                      .css('z-index', '2000')
                      .prependTo($('#fileupload'))

  ).drag((ev, dd) ->
    $(dd.proxy).css
      top:  dd.offsetY
      left: dd.offsetX
  ).drag 'end', (ev, dd) ->
    $(dd.proxy).remove()
  $('.folder-item').drop (ev, dd) ->
    unless dd.drop[0] == dd.drag
      if $(dd.drag).hasClass('folder-item')
        $.post $(dd.drag).find('.folder-data').data('insert-into-url'), {folder: $(dd.drop).attr('id').replace('folder_', '')}, (data)->
          $(dd.drag).remove()

      else
        if $(dd.drag).hasClass('gal-item')
          $.post $(dd.drop).find('.folder-data').data('insert-asset-url'), {asset: $(dd.drag).attr('id').replace(/(picture|attachment_file)_/, '')}, (data)->
            _text = $(dd.drop).find(".folder-assets-count").html()
            _text = _text.replace /(\d+)/g, (digit)->
              parseInt(digit) + 1
            $(dd.drop).find(".folder-assets-count").html(_text)
            $(dd.drag).remove()


$(document).ready ->
  ready()





$(document).delegate '.delete-folder', 'ajax:complete', (xhr, status) ->
  document.location.reload()


$(document).delegate '.folder-item .gal-inner-holder', 'click', (e) ->
  if $(e.currentTarget).find('a.add').length == 0
    e.stopImmediatePropagation()
    document.location = $(e.currentTarget).find('a').attr('href')
    return false

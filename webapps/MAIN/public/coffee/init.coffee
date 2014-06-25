module.exports = ->
    showMenu = (_this, e) ->
        if ($("#cl-wrapper").hasClass("sb-collapsed") or ($(window).width() > 755 and $(window).width() < 963)) and $("ul", _this).length > 0
            $(_this).removeClass "ocult"
            menu = $("ul", _this)
            unless $(".dropdown-header", _this).length
                head = "<li class=\"dropdown-header\">" + $(_this).children().html() + "</li>"
                menu.prepend head
            tool.appendTo "body"
            top = ($(_this).offset().top + 8) - $(window).scrollTop()
            left = $(_this).width()
            tool.css
                top : top
                left : left + 8

            tool.html "<ul class=\"sub-menu\">" + menu.html() + "</ul>"
            tool.show()
            menu.css "top", top
        else
            tool.hide()
        return

    $(".cl-vnavigation li ul").each ->
        $(this).parent().addClass "parent"
        return

    $(".cl-vnavigation li ul li.active").each ->
        $(this).parent().show().parent().addClass "open"
        return

    $(".cl-vnavigation").delegate ".parent > a", "click", (e) ->
        $(".cl-vnavigation .parent.open > ul").not($(this).parent().find("ul")).slideUp 300, "swing", ->
            $(this).parent().removeClass "open"
            return

        ul = $(this).parent().find("ul")
        ul.slideToggle 300, "swing", ->
            p = $(this).parent()
            if p.hasClass("open")
                p.removeClass "open"
            else
                p.addClass "open"
            $("#cl-wrapper .nano").nanoScroller preventPageScrolling : true
            return

        e.preventDefault()
        return

    $(".cl-toggle").click (e) ->
        ul = $(".cl-vnavigation")
        ul.slideToggle 300, "swing", ->

        e.preventDefault()
        return

    $("#sidebar-collapse").click ->
        toggleSideBar()
        return

    $(".nano").nanoScroller()

    tool = $("<div id='sub-menu-nav' style='position:fixed;z-index:9999;'></div>")
    $(".cl-vnavigation li").hover ((e) ->
        showMenu this, e
        return
    ), (e) ->
        tool.removeClass "over"
        setTimeout (->
            tool.hide()  if not tool.hasClass("over") and not $(".cl-vnavigation li:hover").length > 0
            return
        ), 500
        return

    tool.hover ((e) ->
        $(this).addClass "over"
        return
    ), ->
        $(this).removeClass "over"
        setTimeout (->
            tool.fadeOut "fast"  if not tool.hasClass("over") and not $(".cl-vnavigation li:hover").length > 0
            return
        ), 500
        return

    $(document).click ->
        tool.hide()
        return

    $(document).on "touchstart click", (e) ->
        tool.fadeOut "fast"
        return

    tool.click (e) ->
        e.stopPropagation()
        return

    $(".cl-vnavigation li").click (e) ->
        if (($("#cl-wrapper").hasClass("sb-collapsed") or ($(window).width() > 755 and $(window).width() < 963)) and $("ul", this).length > 0) and not ($(window).width() < 755)
            showMenu this, e
            e.stopPropagation()
        return


    #Return to top
    offset = 220
    duration = 500
    button = $("<a href=\"#\" class=\"back-to-top\"><i class=\"fa fa-angle-up\"></i></a>")
    button.appendTo "body"
    jQuery(window).scroll ->
        if jQuery(this).scrollTop() > offset
            jQuery(".back-to-top").fadeIn duration
        else
            jQuery(".back-to-top").fadeOut duration
        return

    jQuery(".back-to-top").click (event) ->
        event.preventDefault()
        jQuery("html, body").animate
            scrollTop : 0
        , duration
        false

    $("body").css
        opacity : 1
        "margin-left" : 0


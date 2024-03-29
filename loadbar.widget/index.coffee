command: "sysctl -n vm.loadavg | awk '{print $2}'"
refreshFrequency: 2500
render: (_) -> """
  <progress class='bar' value='0' max='6'></progress>
"""

update: (output, domEl) ->
  load = parseFloat(output,10)
  $bar = $(domEl).find('.bar')
  $bar.removeClass("highest higher high normal")
  $bar.css width: $(domEl).height()
  $bar.attr 'value': load
  colorclass = switch
    when load > 4 then 'highest'
    when load > 3 then 'higher'
    when load > 2 then 'high'
    when load > 1 then 'normal'
    else 'low'
  $bar.addClass colorclass

style: """
  left: 5px
  top: 100%
  border: none
  width: 100%
  height: 100%
  background: transparent
  box-sizing: border-box
  padding: 0
  text-align: justify

  progress
    transform-origin: left bottom
    transform: rotate(-90deg)
    width: 100%
    height: 5px
    -webkit-appearance: none
    -moz-appearance: none
    appearance: none
    border: none
    background-color: transparent
    &::-webkit-progress-bar
      background-color: transparent
    &::-webkit-progress-value
      background-color: rgba(255,255,255,.5)
      transition: all 1s linear

  .low::-webkit-progress-value
    background-color: rgba(134, 229, 255, .05)

  .normal::-webkit-progress-value
    background-color: rgba(134, 255, 153, .25)

  .high::-webkit-progress-value
    background-color: rgba(243, 255, 134, .65)

  .higher::-webkit-progress-value
    background-color: rgba(185, 134, 255, .75)

  .highest::-webkit-progress-value
    background-color: rgba(255, 71, 71, 1)
"""

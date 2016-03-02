module.exports = (robot) ->

      robot.respond /iqs run (.*)/i, (res) ->
        tag = res.match[1]
        res.reply "OK running the testset tagged with " + tag + " in iqs"

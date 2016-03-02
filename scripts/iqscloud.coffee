module.exports = (robot) ->

      robot.respond /iqs run (.*)/i, (rep) ->
        tag = rep.match[1]
        rep.reply ":rocket: OK, running the testset tagged with " + tag + " in iqs\nI'll report back the results when done."
        encTag =
        robot.http("https://iqscloud.infraxis.com/IQScloudWeb/IQScloudManager/api?token=8zf0bb1ue0qkk8x0&tag=#{tag}")
        .header('Accept', 'application/json')
        .get() (err, res, body) ->
          # error checking code here
          if res.statusCode isnt 200
            data = JSON.parse body
            rep.send ":broken_heart: Hmm, running #{tag} in iqs didn't work out. #{data.message}"
            return
          data = JSON.parse body
          rep.send ":thumbsup: iqs has finished testset #{tag}\n
:smile: passed : #{data.passed}\n
:unamused: failed : #{data.failed}\n
:anguished: aborted: #{data.aborted}"

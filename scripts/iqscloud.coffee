iqstoken = process.env.IQS_TOKEN

module.exports = (robot) ->

      robot.respond /run iqs test (.*)/i, (rep) ->
        tag = rep.match[1]
        rep.reply ":rocket: OK, running the testset tagged with " + tag + " in iqs - I'll report back the results when done."
        robot.http("https://iqscloud.infraxis.com/IQScloudWeb/IQScloudManager/api?token=#{iqstoken}&tag=#{tag}")
        .header('Accept', 'application/json')
        .get() (err, res, body) ->
          # error checking code here
          if res.statusCode isnt 200
            data = JSON.parse body
            rep.reply ":broken_heart: Hmm, running #{tag} in iqs didn't work out. #{data.message}"
            return
          data = JSON.parse body
          rep.reply ":thumbsup: iqs has finished testset #{tag}\n
:smile: passed : #{data.passed}\n
:unamused: failed : #{data.failed}\n
:anguished: aborted: #{data.aborted}\n
:no_mouth: no result: #{data.noresult}\n
:nerd_face: passed percent: #{data.passedpercent}%"

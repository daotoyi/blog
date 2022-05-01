---
title: "IFTTT"
date: "2022-03-17 19:30:00"
lastmod: "2022-04-30 12:48:24"
categories: ["Tools"]
draft: false
---

## if rssfeed, then telegram {#if-rssfeed-then-telegram}

-   [用 IFTTT 让 Telegram 变得更加「聪明」](https://huginn.cn/blog/share/%e7%94%a8-ifttt-%e8%ae%a9-telegram-%e5%8f%98%e5%be%97%e6%9b%b4%e5%8a%a0%e3%80%8c%e8%81%aa%e6%98%8e%e3%80%8d)


## webhoos {#webhoos}

-   [Python 发送手机通知教程](https://mp.weixin.qq.com/s/eOjukUh0ggFGqkYdD3l8rg)


### make request - JSON body {#make-request-json-body}

To trigger an Event with an arbitrary JSON payload
Make a POST or GET web request to:

<https://maker.ifttt.com/trigger/%7Bevent%7D/json/with/key/bMhBKbwkXMxADTWok23HtB>
 Note the extra /json path element in this trigger.

With any JSON body. For example:

{ "this" : [ { "is": { "some": [ "test", "data" ] } } ] }


### make request - options JSON body {#make-request-options-json-body}

To trigger an Event with 3 JSON values

Make a POST or GET web request to:

<https://maker.ifttt.com/trigger/%7Bevent%7D/with/key/bMhBKbwkXMxADTWok23HtB>

With an optional JSON body of:

{ "value1" : "", "value2" : "", "value3" : "" }

```python
class IFTTT():
  def __init__():
      self.key = {IFTT.token}

  def send_notice(sefl, event_name, text):
      url = f"https://maker.ifttt.com/trigger/{event_name}/json/with/key/{self.key}"
      payload = {"value1": text}
      headers = {"Content-Type": "application/json"}
      response = requests.request("POST", url, data=json.dumps(payload), headers=headers)

IFTTT().send_notice(event_name='dyQuant', text=msg)
```


### command line {#command-line}

You can also try it with curl from a command line.

```bash
curl -X POST -H "Content-Type: application/json" -d '{"this":[{"is":{"some":["test","data"]}}]}' https://maker.ifttt.com/trigger/{event}/json/with/key/bMhBKbwkXMxADTWok23HtB
```

```bash
curl -X POST https://maker.ifttt.com/trigger/{event}/with/key/bMhBKbwkXMxADTWok23HtB
```


## Ref {#ref}

-   [王掌柜带你玩转 Zapier - Zapier vs. IFTTT](https://sspai.com/post/39258)
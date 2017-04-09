# Punchcard

Very simple event tracking system.

## Usage:

Define events in settings/[enviroment].yml:

```
events:
  some_event: 391e962681972d5625fc3574e112a4bdae603550
```

The URL you should hit when your event fires is at https://example.com/p/391e962681972d5625fc3574e112a4bdae603550 .

The URL your stats will be visible is https://example.com/stats/some_event .

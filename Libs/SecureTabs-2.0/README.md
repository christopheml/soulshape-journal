# SecureTabs-2.0 :bookmark_tabs:
Adds functional blizzard looking tabs to secure panels without causing taint.

:bulb: Note that it is not possible to hide the original content of the panel without causing taint.
As such, you should create a frame that covers the original content. When your tab is selected, your frame will be shown and the end result will be the same.


## Usage Example
This code adds a tab to the `MerchantFrame`, which manages displaying a custom `MyFrame` whenever the tab is selected:

```
local tab = LibStub('SecureTabs-2.0'):Add(MerchantFrame)
tab:SetText('My Tab Title')
tab.frame = MyFrame

tab.OnSelect = function()
  print('Tab was clicked!')
end

tab.OnDeselect = function()
  print('A different tab was clicked!')
end
```

`MyFrame` is optional. You can manage behaviour yourself using `.OnSelect` and `OnDeselect`. Just make sure to not cause taint if you do.

## To Devs
If you use this library, please list it as one of your dependencies in the CurseForge admin system. It's a big help! :+1:

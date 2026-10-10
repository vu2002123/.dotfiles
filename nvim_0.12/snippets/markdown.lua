return {
	s(
		"cols",
		fmt(
			[[
<div class="columns left-40">
<div>

{}

</div>
<div>

![center w:{}]({})

</div>
</div>
]],
			{
				i(1, "- Your text here"),
				i(2, "700"),
				i(3, "images/image.png"),
			}
		)
	),
	s(
		"ref",
		fmt(
			[[
<span class="ref">{}</span>
]],
			{
				i(1, "Your reference"),
			}
		)
	),
	s(
		"conclude",
		fmt(
			[[
<span class="conclusion">{}</span>
]],
			{
				i(1, "Your conclusion"),
			}
		)
	),
	s(
		"images",
		fmt(
			[[
![center width:{}](images/{})
]],
			{
				i(1, "Width"),
				i(2, "Image name"),
			}
		)
	),
	s(
		"header",
		fmt(
			[[
<!-- _header: {}-->
]],
			{
				i(1, "Your header"),
			}
		)
	),
	s(
		"footer",
		fmt(
			[[
<!-- footer: {}-->
]],
			{
				i(1, "Your footer"),
			}
		)
	),
}

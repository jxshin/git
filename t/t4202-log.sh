. "$TEST_DIRECTORY/lib-log-graph.sh"

test_cmp_graph () {
	lib_test_cmp_graph --format=%s "$@"
}
$(git rev-parse --short :/sixth  ) sixth
$(git rev-parse --short :/fifth  ) fifth
$(git rev-parse --short :/fourth ) fourth
$(git rev-parse --short :/third  ) third
$(git rev-parse --short :/second ) second
$(git rev-parse --short :/initial) initial
# Note that these commits are intentionally listed out of order.
last_three="$(git rev-parse :/fourth :/sixth :/fifth)"
$(git rev-parse --short :/sixth ) sixth
$(git rev-parse --short :/fifth ) fifth
$(git rev-parse --short :/fourth) fourth
	git log --no-walk --oneline $last_three > actual &&
	git log --no-walk=sorted --oneline $last_three > actual &&
=== $(git rev-parse --short :/sixth ) sixth
=== $(git rev-parse --short :/fifth ) fifth
=== $(git rev-parse --short :/fourth) fourth
	git log --line-prefix="=== " --no-walk --oneline $last_three > actual &&
$(git rev-parse --short :/fourth) fourth
$(git rev-parse --short :/sixth ) sixth
$(git rev-parse --short :/fifth ) fifth
	git log --no-walk=unsorted --oneline $last_three > actual &&
	git show --oneline -s $last_three > actual &&
	test_cmp_graph
	test_cmp_graph --line-prefix="123 "
	test_cmp_graph --date-order
	test_cmp_graph --line-prefix="| | | " --date-order
	lib_test_cmp_colored_graph --date-order --format=%s
	test_cmp_graph --date-order
	cat >expect.no-decorate <<-\EOF &&
	Merge-tag-reach
	Merge-tags-octopus-a-and-octopus-b
	seventh
	octopus-b
	octopus-a
	reach
	EOF
	git log -n6 --decorate=short --pretty="tformat:%f%d" \
		--decorate-refs="heads/octopus*" >actual &&
	test_cmp expect.decorate actual &&
		--decorate-refs-exclude="heads/octopus*" \
		--decorate-refs="heads/octopus*" >actual &&
	test_cmp expect.no-decorate actual &&
	git -c log.excludeDecoration="heads/octopus*" log \
		-n6 --decorate=short --pretty="tformat:%f%d" \
	test_cmp expect.decorate actual &&
	git -c log.excludeDecoration="heads/octopus*" log \
		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
	test_cmp expect.decorate actual &&
	git -c log.excludeDecoration="tags/reach" log \
		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
	test_cmp expect.decorate actual &&
	git -c log.excludeDecoration="heads/octopus*" \
		-c log.excludeDecoration="tags/reach" log \
		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
	test_cmp expect.decorate actual &&
	git -c log.excludeDecoration="heads/octopus*" log \
		--decorate-refs-exclude="tags/reach" \
		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
	cat >expect.no-decorate <<-\EOF &&
	test_cmp expect.no-decorate actual
'

test_expect_success 'deocrate-refs and log.excludeDecoration' '
	cat >expect.decorate <<-\EOF &&
	Merge-tag-reach (master)
	Merge-tags-octopus-a-and-octopus-b
	seventh
	octopus-b (octopus-b)
	octopus-a (octopus-a)
	reach (reach)
	EOF
	git -c log.excludeDecoration="heads/oc*" log \
		--decorate-refs="heads/*" \
		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
	test_cmp expect.decorate actual &&
	git -c log.excludeDecoration="*octopus*" log \
		-n6 --decorate=short --pretty="tformat:%f%d" \
		--simplify-by-decoration >actual &&
| | index BEFORE..AFTER
| | |   index BEFORE..AFTER
| |   index BEFORE..AFTER
|   index BEFORE..AFTER
| | | | index BEFORE..AFTER
| | | |   index BEFORE..AFTER
| | | | index BEFORE..AFTER
| | | | index BEFORE..AFTER
| | |   index BEFORE..AFTER
| | | index BEFORE..AFTER
| |   index BEFORE..AFTER
|   index BEFORE..AFTER
|   index BEFORE..AFTER
| index BEFORE..AFTER 100644
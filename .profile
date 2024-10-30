# 思路：在使用此脚本的时候，请确保没有config文件，否则会对代码逻辑造成干扰！
# 作者：刘杨思源
# 完成时间：2024年10月30日12点53分
# 思路：首先检查代理是否启动。
# 最简单的方式是检查环境变量SSH_AGENT_SOCK的值。如果它有被设置，那么代理很可能已经启动。
# 可以使用 echo $SSH_AGENT_SOCK 检查。
# 然后选择要登录的平台（目前仅限于github和gitee）。
# 之后，使用 ssh-add -l 指令查看添加了哪些密钥对。
# 如果什么都没有添加，就将当前选择的平台所对应的指令
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; } # 检查环境变量文件是否存在，并且忽略输出信息。

agent_start () {
    (umask 077; ssh-agent >| "$env") # 启动ssh-agent，并将返回的地址信息重定向到环境变量，且忽略输出。
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?) # 判断ssh-agent状态。（这样做的理由是：git bash里缺少使用pid检查进程的重要指令，因此只能用这种不太准确的方式进行判断。如果手动关闭了ssh-agent，那么这个文件不会自动接收更新的信息。）
if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
fi

# 手动选择线上的Git仓库，然后返回指定的密钥路径。
Github=0
Gitee=1
echo "为了避免出错，请不要手动退出ssh-agent！"
read -p "请选择Git仓库的位置。必须是一个整数。如果是Github，就输入0；如果是Gitee，就输入1：" -t 30 GitUpload
select_git(){
	if (($GitUpload == 0));
	then
		FilePath="E:/me/OpenSShFile/Github.key"
	else
		FilePath="E:/me/OpenSShFile/Gitee.key"
	fi
	# echo "$FilePath" # 这是调试用的语句。
}

select_git

test_conn(){
	# 根据选择的平台测试连接
	if (($GitUpload == 0));
	then
		ssh -T git@github.com # 如果测试失败，就返回255。在 github 测试失败时，会自动尝试添加密钥，并要求输入密码。但无论你使用哪种方式测试成功，都返回1。
	else
		ssh -T git@gitee.com # 如果测试失败，就返回255。成功返回0。
	fi
	# 由于 github 平台和 gitee 平台测试成功后的返回值不一样，因此不可以用成功的返回值。但是两者测试失败的结果均相同，因此以测试失败的结果为标准。
	return $?
}

ssh_key_count=$(ssh-add -l | grep -c '^[0-9]\+') # 这一行由文心一言生成
# echo $ssh_key_count
# 检查是否向ssh-agent添加了密钥对。
if [ $ssh_key_count == 0 ];
# 如果什么也没有，就直接进入添加流程。
then
	ssh-add "$FilePath"
	test_conn
elif [ $ssh_key_count == 1 ];  # 有一个密钥。
then
	echo "已有一个或多个密钥"
	# if (($GitUpload == 0));
	# then
		# echo -e "\033[36m这一点非常重要！\033[0m"
		# echo "现在将测试github的连接。如果它向你询问密码，请直接回车。"
		# echo "因为你输入密码后，虽然结果是测试成功，但是它并没有将对应的密钥添加到代理中。"
		# echo "下次启动时，还会面对同样的问题。"
		# echo "回车后，询问你密钥的密码的程序是这个脚本，不再是github。"
		# echo "这时，它才会在你输入了正确的密码之后，将密钥添加到代理。"
	# fi
	test_conn
	result=$?
	if [ $result == 255 ]; # 因为两个平台测试成功的返回值不同，但测试失败的返回值相同，因此，必须使用测试失败的结果作为参考。
	then
		echo "测试失败，将重新添加密钥"
		ssh-add "$FilePath"
		test_conn
	fi
else
	# 全满后直接测试连接。
	test_conn
fi

unset env

# 代码逻辑被github干扰。干扰原因：存在ssh的config文件的干扰。
# 时间复杂度O(n)科普

【转】https://blog.csdn.net/qq_41523096/article/details/82142747

---



##### 关于代码的基本操作执行次数，我们用四个生活中的场景，来做一下比喻：

* 场景1：给小灰一条长10寸的面包，小灰每3天吃掉1寸，那么吃掉整个面包需要几天？

答案自然是 3 X 10 = 30天。

如果面包的长度是 N 寸呢？

此时吃掉整个面包，需要 3 X n = 3n 天。

如果用一个函数来表达这个相对时间，可以记作 T（n） = 3n。



* 场景2：给小灰一条长16寸的面包，小灰每5天吃掉面包剩余长度的一半，第一次吃掉8寸，第二次吃掉4寸，第三次吃掉2寸......那么小灰把面包吃得只剩下1寸，需要多少天呢？

这个问题翻译一下，就是数字16不断地除以2，除几次以后的结果等于1？这里要涉及到数学当中的对数，以2位底，16的对数，可以简写为log16。

因此，把面包吃得只剩下1寸，需要 5 X log16 = 5 X 4 = 20 天。

如果面包的长度是 N 寸呢？

需要 5 X logn = 5logn天，记作 T（n） = 5logn。



* 场景3：**给小灰一条长10寸的面包和一个鸡腿，小灰每2天吃掉一个鸡腿。那么小灰吃掉整个鸡腿需要多少天呢？

答案自然是2天。因为只说是吃掉鸡腿，和10寸的面包没有关系 。

如果面包的长度是 N 寸呢？

无论面包有多长，吃掉鸡腿的时间仍然是2天，记作 T（n） = 2。



* 场景4：给小灰一条长10寸的面包，小灰吃掉第一个一寸需要1天时间，吃掉第二个一寸需要2天时间，吃掉第三个一寸需要3天时间.....每多吃一寸，所花的时间也多一天。那么小灰吃掉整个面包需要多少天呢？

答案是从1累加到10的总和，也就是55天。

如果面包的长度是 N 寸呢？

此时吃掉整个面包，需要 1+2+3+......+ n-1 + n = (1+n)*n/2 = 0.5n^2 + 0.5n。

记作 T（n） = 0.5n^2 + 0.5n。

---

#### 场景1：

T（n） = 3n 

最高阶项为3n，省去系数3，转化的时间复杂度为：

T（n） =  O（n）

![640?wx_fmt=png](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9tbWJpei5xcGljLmNuL21tYml6X3BuZy9OdE81c2lhbEpaR3BQR3dJR0REaWFjaWNHS0hlQ2ZVV1oyRTNCSUVnVGJ0QjdGejkzUHpVNjdZS2hDendLVHlZaWJXZDZpYzFpY0NjUzVycnI3aWNrc2Fub3JFRUEvNjQwP3d4X2ZtdD1wbmc)



#### 场景2：

T（n） = 5logn 

最高阶项为5logn，省去系数5，转化的时间复杂度为：

T（n） =  O（logn）

![640?wx_fmt=png](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9tbWJpei5xcGljLmNuL21tYml6X3BuZy9OdE81c2lhbEpaR3BQR3dJR0REaWFjaWNHS0hlQ2ZVV1oyRVNGRDRrVDR2UFd6RGRlTzBObXVvVE9zTnFiWU94MndBRzEwbTBFWXdOMkt3dm5hYTNXUGliN1EvNjQwP3d4X2ZtdD1wbmc)



#### 场景3：

T（n） = 2

只有常数量级，转化的时间复杂度为：

T（n） =  O（1）

![640?wx_fmt=png](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9tbWJpei5xcGljLmNuL21tYml6X3BuZy9OdE81c2lhbEpaR3BQR3dJR0REaWFjaWNHS0hlQ2ZVV1oyRVBYaWNkWmhVZnBVT0JoaWNVVVVrRnd6WWwxek1xVEs2TjhYSXFqaWMwc091OU8yaHZhVGpsRkdZdy82NDA_d3hfZm10PXBuZw)

#### 场景4：

T（n） = 0.5n^2 + 0.5n

最高阶项为0.5n^2，省去系数0.5，转化的时间复杂度为：

T（n） =  O（n^2）

![640?wx_fmt=png](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9tbWJpei5xcGljLmNuL21tYml6X3BuZy9OdE81c2lhbEpaR3BQR3dJR0REaWFjaWNHS0hlQ2ZVV1oyRTJ3WXA4VjJVWVB2ZmVZNkd2V0xZSmE0RWE1aWNVWmdTQjF3OHpncmlhVFFhVENFQ2E4TkFYSG1RLzY0MD93eF9mbXQ9cG5n)



* 这四种时间复杂度究竟谁用时更长，谁节省时间呢？稍微思考一下就可以得出结论：

  O（1）< O（logn）< O（n）< O（n^2）

* 在编程的世界中有着各种各样的算法，除了上述的四个场景，还有许多不同形式的时间复杂度，比如：

  O（nlogn）, O（n^3）, O（m*n），O（2^n），O（n！）

今后遨游在代码的海洋里，我们会陆续遇到上述时间复杂度的算法
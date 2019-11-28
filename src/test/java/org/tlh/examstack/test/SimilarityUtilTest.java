package org.tlh.examstack.test;

import org.junit.Test;
import org.tlh.examstack.utils.SimilarityUtil;

public class SimilarityUtilTest {

    @Test
    public void similarity(){
        String str1="你好啊阿斯蒂芬你";
        String str2="你好啊啊上的飞机发动机啊回答是否还";
        double distancePercent = SimilarityUtil.LevenshteinDistancePercent(str1, str2);
        System.out.println(distancePercent);
    }

}

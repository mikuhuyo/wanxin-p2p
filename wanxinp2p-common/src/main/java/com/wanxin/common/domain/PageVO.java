package com.wanxin.common.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

/**
 * @author yuelimin
 * @version 1.0.0
 * @since 1.8
 */
public class PageVO<T> implements Iterable<T>, Serializable {

    private List<T> content = new ArrayList<T>();
    private long total;
    private int pageNo;
    private int pageSize;

    public PageVO() {
    }

    public PageVO(List<T> content, long total, int pageNo, int pageSize) {
        this.content = content;
        this.total = total;
        this.pageNo = pageNo;
        this.pageSize = pageSize;
    }

    /**
     * Returns if there is a previous page.
     *
     * @return if there is a previous page.
     */
    public boolean hasPrevious() {
        return getPageNo() > 0;
    }

    /**
     * Returns if there is a next page.
     *
     * @return if there is a next page.
     */
    public boolean hasNext() {
        return getPageNo() + 1 < getTotalPage();
    }

    /**
     * Returns whether the current page is the first one.
     *
     * @return whether the current page is the first one.
     */
    public boolean isFirst() {
        return !hasPrevious();
    }

    /**
     * Returns whether the current  page is the last one.
     *
     * @return whether the current  page is the last one.
     */
    boolean isLast() {
        return !hasNext();
    }

    /**
     * Returns the total amount of elements of all pages.
     *
     * @return the total amount of elements of all pages.
     */
    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    /**
     * Returns the number of total pages.
     *
     * @return the number of total pages
     */
    public int getTotalPage() {
        return getPageSize() == 0 ? 1 : (int) Math.ceil((double) total / (double) getPageSize());
    }

    /**
     * Returns the page content as unmodifiable {@link List}.
     *
     * @return Returns the page content as unmodifiable {@link List}
     */
    public List<T> getContent() {
        return Collections.unmodifiableList(content);
    }

    public void setContent(List<T> content) {
        this.content = content;
    }

    /**
     * Returns whether the current page has content.
     *
     * @return whether the current page has content.
     */
    public boolean hasContent() {
        return getContentSize() > 0;
    }

    /**
     * Returns the number of elements on current page.
     *
     * @return the number of elements on current page.
     */
    public int getContentSize() {
        return content.size();
    }

    /**
     * Returns the number of items of each page.
     *
     * @return the number of items of each page
     */
    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    /**
     * Returns the number of current page. (Zero-based numbering.)
     *
     * @return the number of current page.
     */
    public int getPageNo() {
        return pageNo;
    }

    /**
     * Set the number of current page. (Zero-based numbering.)
     */
    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public Iterator<T> iterator() {
        return getContent().iterator();
    }
}
